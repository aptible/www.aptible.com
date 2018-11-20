import React, { Component } from 'react';
import ProductSelectionPresentation from '../presentation/ProductSelection';

class ProductSelection extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  static className() {
    return 'ProductSelection';
  }

  selectGridiron = () => {
    this.props.nextStep({ 'gridiron': '1' });
  }

  selectEnclave = () => {
    this.props.nextStep({ 'enclave': '1' });
  }

  render() {
    return (
      <ProductSelectionPresentation
        selectGridiron={this.selectGridiron}
        selectEnclave={this.selectEnclave}
      />
    );
  }
}

export default ProductSelection;
