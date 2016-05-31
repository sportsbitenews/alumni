var ManagerForm = React.createClass({
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
      <form action={Routes.set_manager_city_path(this.props.city)} className="simple_form">
        <input type="hidden" name="_method" value="post" />
        <input type='hidden' name='authenticity_token' value={this.props.token} />
        <div className="padded-1em" id='add-manager-box'>
          <div>
            <input className='form-control' ref='managerSlug' type='text' name='slug' placeholder='a github nickname' />
          </div>
          <button id='add-manager-button' type='submit' onClick={this.handleSubmit}>
            <i className="mdi mdi-plus" />
          </button>
          <div className={errorClasses}><em>{errorContent}</em></div>
        </div>
      </form>
    );
  },
  handleSubmit(e) {
    e.preventDefault();
    axios.railsPost(
      Routes.set_manager_city_path(id: this.props.city),
      {
        slug: this.refs.managerSlug.value,
        format: 'json'
      }
    ).then((response) => {
      this.setState({
        content: response.data.content,
        renderedContent: response.data.rendered_content
      });
    });
  }
});
