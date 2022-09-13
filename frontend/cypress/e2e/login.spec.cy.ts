describe('Login', () => {

  beforeEach(() => {
    cy.visit('/login')
  })

  it('should type email and password', async () => {
    cy.get("[data-test=input-email]")
      .type('email@email.com')
      .should('have.value', 'email@email.com')

    cy.get("[data-test=input-password]")
      .type('password1234')
      .should('have.value', 'password1234')

  })

  it('should redirect to forgot-pass', async () => {
    cy.contains("Esqueceu sua senha?")
      .click()

    cy.url()
      .should('include', '/forgot-pass')

  })

  it('should redirect to register', async () => {
    cy.contains("Cadastrar-se")
      .click()

    cy.url()
      .should('include', '/register')
  })
})
