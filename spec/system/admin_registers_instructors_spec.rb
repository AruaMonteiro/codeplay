require 'rails_helper'

describe 'Admin registers inspectors' do
  it 'from index page' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_link('Registrar um Professor',
                              href: new_instructor_path)
  end

  it 'successfully' do
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'

    fill_in 'Nome', with: 'Aruã'
    fill_in 'Email', with: 'arua@arua.com'
    fill_in 'Descrição', with: 'sou um professor maneiro'
    click_on 'Cadastrar professor'

    expect(current_path).to eq(instructor_path(Instructor.last))
    expect(page).to have_content('Aruã')
    expect(page).to have_content('arua@arua.com')
    expect(page).to have_content('sou um professor maneiro')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'
    fill_in 'Email', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Cadastrar professor'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and code must be unique' do
    Instructor.create!(name: 'Aruã', email:'arua@arua.com', bio: 'Um professor maneiro')

    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'
    fill_in 'Email', with: 'arua@arua.com'
    click_on 'Cadastrar professor'

    expect(page).to have_content('já está em uso')
  end
end