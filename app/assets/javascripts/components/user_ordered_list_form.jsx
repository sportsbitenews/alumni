var UserOrederedListForm = React.createClass({
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
    axios.railsPatch(
      Routes.ordered_list_path(this.props.orderedListId, { format: 'json' }),
      {
        'github_nickname': React.findDOMNode(this.refs.memberSlug).value,
        'position': this.props.position,
        'add': true
      }
    ).then((response) => {
      this.setState({
        errors: response.data.errors,
        errorContent: response.data.error_content
      });
      this.props.updateMembersList(response.data.members);
      React.findDOMNode(this.refs.memberSlug).value = '';
    });
  }
});
