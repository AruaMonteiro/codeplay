require 'rails_helper'

describe 'Admin view instructors' do
  it 'successfully' do
    Instructor.create!(name: 'Joao', email: 'joao@joao.com',
                   bio: 'Eu sou o Joao, professor de ruby')
    Instructor.create!(name: 'Jose', email: 'jose@jose.com',
                   bio: 'Eu sou o Jose, professor de ruby')

    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Joao')
    expect(page).to have_content('Jose')
  end

  it 'and view details' do
    instructor = Instructor.create!(name: 'Joao', email: 'joao@joao.com',
                   bio: 'Eu sou o Joao, professor de ruby')
    instructor.profile_picture.attach(io: File.open(Rails.root.join('spec', 'support', 'profile.png')), filename: 'profile.png')
    visit root_path
    click_on 'Professores'
    click_on 'Joao'

    expect(page).to have_content('Joao')
    expect(page).to have_content('joao@joao.com')
    expect(page).to have_content('Eu sou o Joao, professor de ruby')
  end

  it 'and no instructor is available' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Nenhum professor cadastrado')
  end
end