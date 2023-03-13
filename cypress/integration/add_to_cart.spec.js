/* eslint-disable no-undef */

describe('Cart', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("Add to cart on the home page and in doing so their cart increases by one", () => {
    cy.get(':nth-child(1) > div > .button_to > .btn').click({ force: true });
    cy.get('.end-0 > .nav-link').should('include.text', '(1)');
  });


});
