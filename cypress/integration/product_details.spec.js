describe('Product Detail Navigation', () => {
    it('allows a user to navigate from the home page to a product detail page', () => {

      // Visit home page
      cy.visit('http://127.0.0.1:3000/');
  
      // Select first product's link and click it
      cy.get('article').first().click();
  
      // Assert that the URL has changed to a product detail page.
      cy.url().should('include', '/products/');
      });
  });
  