require 'rails_helper'

describe 'Admin deletes courses' do
  it 'successfully' do
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
      code: 'RUBYBASIC', price: 10,
      enrollment_deadline: '22/12/2033')

    visit course_path(course)
    click_on 'Apagar'

    expect(current_path).to eq(courses_path)
    expect(page).to have_content('Curso apagado com sucesso.')
  end
end