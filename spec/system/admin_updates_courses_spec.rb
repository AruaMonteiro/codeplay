require 'rails_helper'

describe 'Admin updates courses' do
  it 'successfully' do
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
      code: 'RUBYBASIC', price: 10,
      enrollment_deadline: '22/12/2033')

    visit course_path(course)
    click_on 'Editar'

    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de Ruby on Rails'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '30'
    fill_in 'Data limite de matrícula', with: Date.current.strftime('%d/%m/%Y')
    click_on 'Salvar'

    expect(current_path).to eq(course_path(Course.last))
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content(Date.current.strftime('%d/%m/%Y'))
    expect(page).to have_content('Curso atualizado com sucesso.')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033')

    visit course_path(course)
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Preço', with: ''
    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  it 'and code must be unique' do
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033')
    
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC2', price: 10,
                   enrollment_deadline: '22/12/2033')
    
    visit course_path(course)
    click_on 'Editar'

    fill_in 'Código', with: 'RUBYBASIC'
    click_on 'Salvar'

    expect(page).to have_content('já está em uso')
  end
end