describe('product details page', () => {

  it('can visit the homepage', () => {
    cy.visit('http://localhost:3000/')
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 12 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });

  it('lets you visit the selected product detail page', () => {
    cy.visit('/')
    cy.get(".products article").first().click()
    cy.url().should("include", "/products/2")
  
  })

});