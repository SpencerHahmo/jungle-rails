describe('cart page', () => {

  it('can visit the homepage', () => {
    cy.visit('/')
  });

  it('shows the correct number of items in the cart', () => {
    cy.contains('My Cart (0)')
    cy.visit('/cart')
    cy.contains("Your cart is empty. You can look through our plants here");
    cy.visit('/')    
    cy.contains('Add').first().click({force: true})
    cy.contains('My Cart (1)')
    cy.contains('Add').first().click({force: true})
    cy.contains('My Cart (1)')
    cy.visit('/cart')
    cy.contains("Your cart is empty. You can look through our plants here").should("not.exist");
    cy.contains('+').first().click()
    cy.contains('My Cart (1)')    
  })


});