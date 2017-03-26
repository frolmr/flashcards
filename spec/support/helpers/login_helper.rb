module LoginHelper
  def login
    visit login_path
    fill_in I18n.t('simple_form.labels.user.email'), with: "test@test.com"
    fill_in I18n.t('simple_form.labels.user.password'), with: "foobar"
    click_button I18n.t('log_in')
  end
end
