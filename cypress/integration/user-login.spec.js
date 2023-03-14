/* eslint-disable no-undef */

describe('User Page', () => {

  it("Sign up in and navigate to Home Page", () => {
    cy.visit('/signup');
    cy.get('#user_first_name').type("V");
    cy.get('#user_last_name').type("T");
    cy.get('#user_email').type("vt@gmail.com");
    cy.get('#user_password').type("123");
    cy.get('#user_password_confirmation').type("123");
    cy.get('[type="submit"]').click();
  });

  it("Log in and navigate to Home Page", () => {
    cy.visit('/login');
    cy.get('#email').type("vt@gmail.com");
    cy.get('#password').type("123");
    cy.get('[type="submit"]').click();
    cy.get('#display_email').should('include.text', "vt@gmail.com");
  });
});
