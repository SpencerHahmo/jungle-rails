describe('home page', () => {

  it('can visit the homepage', () => {
    cy.visit('http://localhost:3000/')

  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });


});