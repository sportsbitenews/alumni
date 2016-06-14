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
    if (this.props.testimonial == null) {
      var githubNicknameDefaultValue = '';
      var contentDefaultValue = '';
      var localeDefaultValue = 'en';
      var submitBtnText = 'Add';
    }
    else {
      var githubNicknameDefaultValue = this.props.testimonial.user.slug;
      var contentDefaultValue = this.props.testimonial.content;
      var localeDefaultValue = this.props.testimonial.locale;
      var submitBtnText = 'Update';
    }
    return (
      <form action="" className="simple_form" onSubmit={this.handleSubmit}>
        <div className="form-group bottom-padded-1em">
          <label>{"Author's GitHub nickname"}</label>
          <input type="text" ref="github_nickname" className="form-control" defaultValue={githubNicknameDefaultValue} />
          <div className={errorClasses}><em>{this.state.error_content}</em></div>
        </div>
        <div className="form-group bottom-padded-1em">
          <label>Content</label>
          <textarea type="text" ref="content" className="form-control" defaultValue={contentDefaultValue} />
        </div>
        <div className="form-group bottom-padded-1em">
          <label>Locale</label>
          <select ref="locale" className="form-control" defaultValue={localeDefaultValue}>
            <option value="fr">fr</option>
            <option value="en">en</option>
          </select>
        </div>
        <button type="submit" className="btn btn-primary">{submitBtnText}</button>
        <div className="btn btn-primary" onClick={this.onCancelClick}>Cancel</div>
      </form>
    );
  },
  handleSubmit(e) {
    e.preventDefault();
    if (this.props.testimonial == null) {
      var verb = 'post';
      var url = Routes.testimonials_path({ format: 'json' });
    }
    else {
      var verb = 'patch';
      var url = Routes.testimonial_path(this.props.testimonial.id, { format: 'json' });
    }
    axios._action(verb, url,
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
      if (!this.state.errors) {
        this.props.closeTestimonialForm();
        this.props.updateTestimonialList(response.data.testimonials);
      }
    });
  },
  onCancelClick(e) {
    e.preventDefault();
    this.props.closeTestimonialForm();
  }
});
