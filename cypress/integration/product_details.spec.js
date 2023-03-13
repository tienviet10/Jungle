/* eslint-disable no-undef */

describe('Product Page', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("Navigate to product page by clicking on product", () => {
    cy.get("[alt='Giant Tea']").click();
  });


});
