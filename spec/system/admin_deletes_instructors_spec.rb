require 'rails_helper'

describe 'Admin deletes instructors' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Aruã', email:'arua@arua.com', bio: 'Um professor maneiro')

    visit instructor_path(instructor)
    click_on 'Apagar'

    expect(current_path).to eq(instructors_path)
    expect(page).to have_content('Professor apagado com sucesso.')
  end
end