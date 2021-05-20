require 'rails_helper'

describe 'Admin updates instructors' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Jorge', email:'jorge@arua.com', bio: 'Um professor diferentão')

    visit instructor_path(instructor)
    click_on 'Editar'

    fill_in 'Nome', with: 'Aruã'
    fill_in 'Email', with: 'arua@arua.com'
    fill_in 'Descrição', with: 'sou um professor maneiro'
    attach_file 'Foto de perfil', Rails.root.join('spec', 'support', 'profile.png')
    click_on 'Salvar'

    expect(current_path).to eq(instructor_path(Instructor.last))
    expect(page).to have_content('Aruã')
    expect(page).to have_content('arua@arua.com')
    expect(page).to have_content('sou um professor maneiro')
    expect(page).to have_css('img[src*="profile.png"]')
    expect(page).to have_content('Professor atualizado com sucesso.')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    instructor = Instructor.create!(name: 'Aruã', email:'arua@arua.com', bio: 'Um professor maneiro')

    visit instructor_path(instructor)
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and code must be unique' do
    Instructor.create!(name: 'Aruã', email:'arua@arua.com', bio: 'Um professor maneiro')
    
    instructor = Instructor.create!(name: 'Aruã', email:'arua2@arua.com', bio: 'Um professor maneiro')
    
    visit instructor_path(instructor)
    click_on 'Editar'

    fill_in 'Email', with: 'arua@arua.com'
    click_on 'Salvar'

    expect(page).to have_content('já está em uso')
  end
end