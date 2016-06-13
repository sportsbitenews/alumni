var TestimonialListItem = React.createClass({
  getInitialState() {
    return {
      editing: false
    };
  },
  render: function() {
    var flag = null;
    if (this.props.testimonial.locale == "en") {
      flag = "🇬🇧";
    }
    else if (this.props.testimonial.locale == "fr") {
      flag = "🇫🇷";
    }
    var formClasses = classNames({
      'hidden': !this.state.editing,
      'city_review_card_edit': true
    });
    return (
      <div className="city_review_card">
        <div className="city_review_card_headings">
          <div className="">
            {flag}
          </div>
          <div className="city_review_card_button" onClick={this.onEditClick}>
            <div className="">
              <i className="mdi mdi-lead-pencil" />
            </div>
          </div>
        </div>

        <div className="city_review_card_content">
          {this.props.testimonial.content}
        </div>
        <div className="city_review_card_user_infos">
          <div className="city_review_card_user_avatar">
            <img className="avatar" src={this.props.testimonial.user.thumbnail} />
          </div>
          <div className="">
            {this.props.testimonial.user.full_name}
          </div>
        </div>
        <div className={formClasses}>
          <TestimonialListItemForm
            city_slug={this.props.city_slug}
            updateTestimonialList={this.updateTestimonialList}
            cancelTestimonialForm={this.cancelTestimonialForm}
            testimonial={this.props.testimonial} />
        </div>
      </div>
    );
  },
  onEditClick(e) {
    this.setState({editing:true});
  }
});
