var TestimonialList = React.createClass({
  getInitialState() {
    return {
      testimonials: this.props.testimonials,
      new: false
    };
  },
  updateTestimonialList: function(testimonials) {
    this.setState({testimonials: testimonials});
  },
  cancelTestimonialForm: function() {
    this.setState({new: false});
  },
  render: function() {
    var formClasses = classNames({
      'hidden': !this.state.new
    });
    var addTestimonialListItemClasses = classNames({
      'hidden': this.state.new,
      'testimonial-list-item': true
    });
    var addTestimonialCardClasses = classNames({
      'hidden': this.state.new,
      'city_review_card': true
    });
    return (
      <div className="testimonial-list">
        {this.state.testimonials.map((testimonial, index) => {
          return (
            <div className="testimonial-list-item" key={index}>
              <TestimonialListItem testimonial={testimonial} updateTestimonialList={this.updateTestimonialList} />
            </div>
          )
        })}
        <div className={addTestimonialListItemClasses}>
          <div className={addTestimonialCardClasses} onClick={this.onAddClick}>
            <div id="testimonial-add-list-item" className="text-center">
              <i className="mdi mdi-plus" />
            </div>
          </div>
        </div>
        <div className={formClasses} id="testimonial-list-form">
          <TestimonialListItemForm
            city_slug={this.props.city_slug}
            updateTestimonialList={this.updateTestimonialList}
            cancelTestimonialForm={this.cancelTestimonialForm} />
        </div>
      </div>
    );
  },
  onAddClick(e) {
    this.setState({new: true})
  }
});
