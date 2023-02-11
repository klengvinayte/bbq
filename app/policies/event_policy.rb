class EventPolicy < ApplicationPolicy
  def create?
    user.user.present?
  end

  def new?
    create?
  end

  def update?
    user_is_owner?(record)
  end

  def destroy?
    update?
  end

  def show?
    pincode_correct?
  end

  def edit?
    update?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def user_is_owner?(event)
    user.user.present? && (record.user == user.user)
  end

  def pincode_correct?
    return true if record.pincode.blank?
    return true if user_is_owner?(record)

    if user.params[:pincode].present? && record.pincode_valid?(user.params[:pincode])
      user.params[:cookies].permanent["events_#{record.id}_pincode"] = user.params[:pincode]
    end

    record.pincode_valid?(user.params[:cookies].permanent["events_#{record.id}_pincode"])
  end
end
