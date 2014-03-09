class CatRentalRequest < ActiveRecord::Base
  before_validation :set_default_to_pending
  validates :cat_id, :presence => true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED)}
  validate :overlapping_approved_requests, :on => :create
  belongs_to :cat

  def overlapping_requests
    CatRentalRequest.find_by_sql([<<-SQL, self.cat_id, self.start_date, self.end_date, self.start_date, self.end_date, self.start_date, self.end_date])
    SELECT
      *
    FROM
      cat_rental_requests
    WHERE
      cat_id = ?
    AND
      (? BETWEEN start_date AND end_date)
      OR
      (? BETWEEN start_date AND end_date)
      OR
      (start_date BETWEEN ? AND ?)
      OR
      (end_date BETWEEN ? AND ?)
    SQL
  end

  def overlapping_approved_requests
    overlapping_requests.each do |request|
      if request.status == "APPROVED"
        errors.add(:overlapping_approved_requests, "That cat is already rented out")
      end
    end
  end

  def set_default_to_pending
    self.status ||= "PENDING"
  end

  def deny!
    self.status = "DENIED"
    self.save
  end

  def deny_conflicting_request
    overlapping_requests.each do |request|
      request.deny!
    end
  end

  def approve!
    deny_conflicting_request
    self.status = "APPROVED"
    self.save!
  end

  def self.requests_for_cat_id(cat_id)
    CatRentalRequest.find_by_sql([<<-SQL, cat_id])
    SELECT
      *
    FROM
      cat_rental_requests
    WHERE
      cat_id = ?
    ORDER BY
      start_date, status
    SQL
  end

end
