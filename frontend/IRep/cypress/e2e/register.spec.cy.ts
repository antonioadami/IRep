describe('Register', () => {

  beforeEach(() => {
    cy.visit('/register')
  })

  it('should type name, email and password', async () => {
    cy.get("[data-test=input-name]")
      .type('John Doe')
      .should('have.value', 'John Doe')

    cy.get("[data-test=input-email]")
      .type('email@email.com')
      .should('have.value', 'email@email.com')

      cy.get("[data-test=input-password]")
      .type('password1234')
      .should('have.value', 'password1234')
  })
})
