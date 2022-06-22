describe('Forgot Password', () => {

  beforeEach(() => {
    cy.visit('/forgot-pass')
  })

  it('should type email', async () => {
    cy.get("[data-test=input-email]")
      .type('email@email.com')
      .should('have.value', 'email@email.com')
  })
})
