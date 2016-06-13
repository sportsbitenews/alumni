var TestimonialListItemForm = React.createClass({
  getInitialState() {
    return {
      errors: false,
      error_content: ''
    };
  },
  render: function() {
    var errorClasses = classNames({
      'hidden': !this.state.errors,
      'manager-form-errors': true
    });
    return (
      <form action="" className="simple_form" onSubmit={this.handleSubmit}>
        <div className="form-group bottom-padded-1em">
          <label>{"Author's GitHub nickname"}</label>
          <input type="text" ref="github_nickname" className="form-control" />
          <div className={errorClasses}><em>{this.state.error_content}</em></div>
        </div>
        <div className="form-group bottom-padded-1em">
          <label>Content</label>
          <textarea type="text" ref="content" className="form-control" />
        </div>
        <div className="form-group bottom-padded-1em">
          <label>Locale</label>
          <select ref="locale" className="form-control" defaultValue="en">
            <option value="fr">fr</option>
            <option value="en">en</option>
          </select>
        </div>
        <button type="submit" className="btn btn-primary">Add</button>
      </form>
    );
  },
  handleSubmit(e) {
    e.preventDefault();
    axios.railsPost(
      Routes.testimonials_path({ format: 'json' }),
      {
        'github_nickname': React.findDOMNode(this.refs.github_nickname).value,
        'content': React.findDOMNode(this.refs.content).value,
        'locale': React.findDOMNode(this.refs.locale).value,
        'city_slug': this.props.city_slug
       }
    ).then((response) => {
      this.setState({
        errors: response.data.errors,
        error_content: response.data.error_content
      });
      this.props.updateTestimonialList(response.data.testimonials, response.data.errors);
    });
  }
});
