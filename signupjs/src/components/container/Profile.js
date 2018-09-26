import React, { Component } from 'react';
import ProfilePresentation from '../presentation/Profile';

class Profile extends Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '',
      role: '',
      company_name: '',
      company_url: '',
      company_size: '',
      errors: []
    };
  }

  setStateFromEvent = (name, event) => {
    this.setState({ [name]: event.target.value });
  }

  validate = () => {
    const errors = [];
    const fields = ['name', 'role', 'company_name', 'company_url', 'company_size'];

    for (let field of fields) {
      if (this.state[field] === '') {
        errors.push(field);
      }
    }

    this.setState({ errors });
    return errors.length == 0;
  }

  onSubmit = () => {
    if (this.validate()) {
      this.props.nextStep(this.state);
    }
  }

  render() {
    return (
      <ProfilePresentation
        name={this.state.name}
        role={this.state.role}
        company_name={this.state.company_name}
        company_url={this.state.company_url}
        company_size={this.state.company_size}
        onSubmit={this.onSubmit}
        errors={this.state.errors}
        setStateFromEvent={this.setStateFromEvent}
      />
    );
  }
}

export default Profile;
