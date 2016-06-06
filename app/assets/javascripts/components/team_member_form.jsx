var TeamMemberForm = React.createClass({
  getInitialState() {
    return {
      errors: false,
      errorContent: ''
    };
  },
  render: function() {
    var errorClasses = classNames({
      'hidden': !this.state.errors,
      'manager-form-errors': true
    })
    var errorContent = this.state.errorContent
    return (
      <form action="" className="simple_form" onSubmit={this.handleSubmit}>
        <div className="padded-1em" id='add-manager-box'>
          <div>
            <input className='form-control' ref='memberSlug' type='text' name='github_nickname' placeholder='a github nickname' />
          </div>
          <button className='manager-button manager-button-add' type='submit' >
            <i className="mdi mdi-plus" />
          </button>
        </div>
        <div className={errorClasses}><em>{errorContent}</em></div>
      </form>
    );
  },
  handleSubmit(e) {
    e.preventDefault();
    axios.railsPost(
      Routes.set_team_member_city_path(this.props.city, { format: 'json' }),
      {
        'github_nickname': React.findDOMNode(this.refs.memberSlug).value,
        'role': this.props.memberRole
      }
    ).then((response) => {
      this.setState({
        errors: response.data.errors,
        errorContent: response.data.error_content
      });
      this.props.updateManagers(response.data.managers);
      React.findDOMNode(this.refs.managerSlug).value = '';
    });
  }
});
