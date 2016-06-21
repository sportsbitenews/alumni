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
    var userInputClasses = classNames({
      'hidden': this.props.testimonial != null
    });
    if (this.props.testimonial == null) {
      var githubNicknameDefaultValue = '';
      var contentDefaultValue = '';
      var localeDefaultValue = 'en';
      var submitBtnText = 'Add';
      var alumnusPicture = this.props.alumnusDefaultPicture;
    }
    else {
      var githubNicknameDefaultValue = this.props.testimonial.user.slug;
      var contentDefaultValue = this.props.testimonial.content;
      var localeDefaultValue = this.props.testimonial.locale;
      var submitBtnText = 'Update';
      var alumnusPicture = this.props.testimonial.user.thumbnail;
    }
    return (
      <form action="" className="simple_form" onSubmit={this.handleSubmit}>
        <div className="city_review_card_headings">
          <div className="">
            <select ref="locale" className="form-control input-sm" defaultValue={localeDefaultValue}>
              <option value="fr">🇫🇷</option>
              <option value="en">🇬🇧</option>
            </select>
          </div>
          <div className="city_review_card_button" onClick={this.onCancelClick}>
            <div className="">
              <i className="mdi mdi-window-close" />
            </div>
          </div>
        </div>

        <div className="city_review_card_content">
          <textarea type="text" ref="content" className="form-control" defaultValue={contentDefaultValue} placeholder="This 9 weeks were crazy..." />
        </div>
        <div className="city_review_card_user_infos">
          <div className="city_review_card_user_avatar">
            <img className="avatar" src={alumnusPicture} />
          </div>
          <div className={userInputClasses}>
            <input type="text" ref="github_nickname" className="form-control input-sm" defaultValue={githubNicknameDefaultValue} placeholder="a GitHub nickname" />
            <div className={errorClasses}><em>{this.state.error_content}</em></div>
          </div>
        </div>
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
