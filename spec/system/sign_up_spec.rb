require "rails_helper"

RSpec.describe "Sign Up", type: :system do
  before do
    driven_by(:selenium, using: :chrome)
  end

  context "when the user enters valid details" do
    it "allows the user to sign up for an account" do
      visit new_user_registration_path

      expect(page).to have_content "Sign up"

      fill_in "Email", with: "test@example.org"
      fill_in "Password", with: "Password123!"
      fill_in "Password confirmation", with: "Password123!"

      click_button "Sign up"

      expect(page).to have_content "Dashboard"
      expect(page).to have_content "Welcome! You have signed up successfully."
    end
  end

  context "when the user enters invalid details" do
    context "by using an email address that is already registered" do
      let!(:user) { User.create!(email: "test@example.org", password: "Password123!") }

      it "does not allow the user to sign up for an account" do
        visit new_user_registration_path

        expect(page).to have_content "Sign up"

        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        fill_in "Password confirmation", with: user.password

        click_button "Sign up"

        expect(page).to have_content "Email has already been taken"
      end
    end

    context "by leaving all of the required fields empty" do
      it "does not allow the user to sign up for an account" do
        visit new_user_registration_path

        expect(page).to have_content "Sign up"

        click_button "Sign up"

        expect(page).to have_content "Email can’t be blank"
        expect(page).to have_content "Password can’t be blank"
      end
    end

    context "by leaving the email address empty" do
      it "does not allow the user to sign up for an account" do
        visit new_user_registration_path

        expect(page).to have_content "Sign up"

        fill_in "Password", with: "Password123!"
        fill_in "Password confirmation", with: "Password123!"

        click_button "Sign up"

        expect(page).to have_content "Email can’t be blank"
      end
    end

    context "by leaving the password field empty" do
      it "does not allow the user to sign up for an account" do
        visit new_user_registration_path

        expect(page).to have_content "Sign up"

        fill_in "Email", with: "test@example.org"
        fill_in "Password confirmation", with: "Password123!"

        click_button "Sign up"

        expect(page).to have_content "Password can’t be blank"
      end
    end

    context "by leaving the password confirmation field empty" do
      it "does not allow the user to sign up for an account" do
        visit new_user_registration_path

        expect(page).to have_content "Sign up"

        fill_in "Email", with: "test@example.org"
        fill_in "Password", with: "Password123!"

        click_button "Sign up"

        expect(page).to have_content "Password confirmation doesn’t match Password"
      end
    end

    context "by specifying a password that is too short" do
      it "does not allow the user to sign up for an account" do
        visit new_user_registration_path

        expect(page).to have_content "Sign up"

        fill_in "Email", with: "test@example.org"
        fill_in "Password", with: "pass"
        fill_in "Password confirmation", with: "pass"

        click_button "Sign up"

        expect(page).to have_content "Password is too short"
      end
    end

    context "by specifying a password that does not match the confirmation field" do
      it "does not allow the user to sign up for an account" do
        visit new_user_registration_path

        expect(page).to have_content "Sign up"

        fill_in "Email", with: "test@example.org"
        fill_in "Password", with: "Password123!"
        fill_in "Password confirmation", with: "Password"

        click_button "Sign up"

        expect(page).to have_content "Password confirmation doesn’t match Password"
      end
    end
  end
end
