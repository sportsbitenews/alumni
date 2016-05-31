var ManagerForm = React.createClass({
  render: function() {
    return (
      <form action={Routes.set_manager_city_path(this.props.city)} className="simple_form"  method="post" remote="true">
        <input type="hidden" name="_method" value="post" />
        <input type='hidden' name='authenticity_token' value={this.props.token} />
        <div className="padded-1em" id='add-manager-box'>
          <div>
            <input className='form-control' type='text' name='slug' placeholder='a github nickname' />
          </div>
          <div id='add-manager-button' onClick={onAddClick} >
            <i className="mdi mdi-plus" />
          </div>
        </div>
      </form>
    );
  },
  onAddClick(e) {
    e.preventDefault();
    axios.railsPost(
      Routes.set_manager_city_path({
        id: this.props.city, format: 'json'
      })
    ).then((response) => {
      this.setState({
        content: response.data.content,
        renderedContent: response.data.rendered_content
      });
    });
  }
});
