
it("There are 2 products on the page", () => {
  cy.visit("http://127.0.0.1:3000/");
  cy.get(".products article").should("have.length", 2);
});
