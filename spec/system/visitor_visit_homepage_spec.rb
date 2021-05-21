require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_content('CodePlay')
    expect(page).to have_content('Boas vindas ao sistema de gestão de '\
                                         'cursos e aulas')
  end
end