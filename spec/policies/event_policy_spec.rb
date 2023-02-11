require "rails_helper"

RSpec.describe EventPolicy do
  let(:cookie_jar) { ActionDispatch::Cookies::CookieJar.new(nil) }

  let(:user) { UserContext.new(create(:user), { cookies: cookie_jar, pincode: "" }) }
  let(:second_user) { UserContext.new(create(:user), { cookies: cookie_jar, pincode: "" }) }
  let(:guest) { UserContext.new(nil, { cookies: cookie_jar, pincode: "" }) }

  let(:event) { create(:event, user: user.user) }
  let(:event_w_pincode) { create(:event, user: user.user, pincode: "1234") }

  subject { described_class }

  permissions :new?, :create? do
    it "user can create new event" do
      expect(subject).to permit(user, Event.new)
    end

    it "forbids access" do
      expect(subject).not_to permit(guest, Event.new)
    end
  end

  permissions :edit?, :update?, :destroy? do
    context "when user is owner of event" do
      it "user can update, edit, destroy event" do
        expect(subject).to permit(user, event)
      end
    end

    context "when user is guest" do
      it "forbids access" do
        expect(subject).not_to permit(guest, event)
      end
    end

    context "when second user" do
      it "forbids access" do
        expect(subject).not_to permit(second_user, event)
      end
    end
  end

  permissions :show? do
    context "when c no pincode" do
      it "grants access for owner" do
        expect(subject).to permit(user, event)
      end

      it "grants access for another user" do
        expect(subject).to permit(second_user, event)
      end

      it "grants access to guest" do
        expect(subject).to permit(guest, event)
      end
    end

    context "when event has pincode" do
      context "when user is owner" do
        it "grants access" do
          expect(subject).to permit(user, event_w_pincode)
        end
      end

      context "when user is guest" do
        it "denies access for guest" do
          expect(subject).not_to permit(guest, event_w_pincode)
        end

        it "grants access for guest with correct cookies" do
          (guest.params[:cookies]).stub(:permanent).and_return({ "events_#{event_w_pincode.id}_pincode" => "1234" })
          expect(subject).to permit(guest, event_w_pincode)
        end

        it "grants access for guest with pincode" do
          guest.params[:pincode] = "1234"
          (guest.params[:cookies]).stub(:permanent).and_return({})
          expect(subject).to permit(guest, event_w_pincode)
        end
      end

      context "when user is not an owner" do
        it "denies access for user" do
          expect(subject).not_to permit(second_user, event_w_pincode)
        end

        it "grants access for user with correct cookies" do
          (second_user.params[:cookies]).stub(:permanent).and_return({ "events_#{event_w_pincode.id}_pincode" => "1234" })
          expect(subject).to permit(second_user, event_w_pincode)
        end

        it "grants access for user with pincode" do
          second_user.params[:pincode] = "1234"
          (second_user.params[:cookies]).stub(:permanent).and_return({})
          expect(subject).to permit(second_user, event_w_pincode)
        end
      end
    end
  end
end
