import React from 'react';

const ProductSelection = ({ selectGridiron, selectEnclave }) => (
  <div className="signup__step">
    <h2 style={{ marginBottom: '80px' }}>Which product do you want to try today?</h2>

    <a className="signup__product-selection" onClick={selectGridiron}>
      <div className="signup__product-selection__line gridiron"><span></span></div>
      <div className="signup__product-selection__content gridiron">
        <span>Gridiron</span>
        Prepare for and pass information security audits
      </div>
      <div className="signup__product-selection__arrow gridiron">
        <i className="far fa-long-arrow-right"></i>
      </div>
    </a>

    <a className="signup__product-selection" onClick={selectEnclave}>
      <div className="signup__product-selection__line enclave"><span></span></div>
      <div className="signup__product-selection__content enclave">
        <span>Enclave</span>
        Deploy audit-ready apps and databases
      </div>
      <div className="signup__product-selection__arrow enclave">
        <i className="far fa-long-arrow-right"></i>
      </div>
    </a>
  </div>
);

export default ProductSelection;
