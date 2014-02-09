class ListItem < ActiveRecord::Base
  belongs_to :list
  has_many :timers, dependent: :destroy

  def elapsed_minutes
    timers.sum("minutes")
  end

  def done!
    update_attribute(:done_at, Time.zone.now)
    timer_stop! if timer_started?
  end

  def expired?
    if deadline_at
      deadline_at < Time.zone.now.beginning_of_day
    else
      false
    end
  end

  def coming?
    if deadline_at
      deadline_at > Time.zone.now.end_of_day
    else
      false
    end
  end

  def timer_start!
    update_attribute(:timer_started_at, Time.zone.now)
  end

  def timer_stop!
    elapsed_minutes = (Time.zone.now - timer_started_at)/60
    timers.create!(started_at: timer_started_at, minutes: elapsed_minutes)
    update_attribute(:timer_started_at, nil)
  end

  def timer_started?
    !timer_started_at.nil?
  end

  def deadline_set?
    !deadline_at.nil?
  end

  def expiring_today?
    deadline_at.to_date == Date.current.to_date
  end

  def start!
    update_attribute(:started_at, Time.zone.now)
    timer_start!
  end

  def started?
    !started_at.nil?
  end

  def self.deadline_set
    where("deadline_at is not null")
  end

  def self.expiring
    where("deadline_at <= :today", today: Time.zone.now.end_of_day)
  end

  def self.not_expired
    where("deadline_at > :today", today: Time.zone.now.end_of_day)
  end

  def self.order_by_list
    order("list_id")
  end

  def self.not_done
    where("done_at is null")
  end

  def self.done
    where("done_at is not null")
  end

  def self.not_started
    where("started_at is null")
  end

  def self.order_by_deadline
    order("deadline_at desc")
  end

  def self.order_by_created_at
    order("created_at desc")
  end

  def self.started
    where("started_at is not null")
  end
end
