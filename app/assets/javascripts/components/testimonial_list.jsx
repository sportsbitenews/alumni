var TestimonialList = React.createClass({
  getInitialState() {
    return {
      testimonials: this.props.testimonials,
      isFormOpen: false
    };
  },
  updateTestimonialList: function(testimonials) {
    this.setState({testimonials: testimonials});
  },
  closeTestimonialForm: function() {
    this.setState({isFormOpen: false});
  },
  render: function() {
    var formClasses = classNames({
      'hidden': !this.state.isFormOpen,
      'city_review_card': true
    });
    var addTestimonialCardClasses = classNames({
      'hidden': this.state.isFormOpen,
      'city_review_card': true
    });
    return (
      <div className="testimonial-list">
        {this.state.testimonials.map((testimonial, index) => {
          return (
            <div className="testimonial-list-item" key={index}>
              <TestimonialListItem
                testimonial={testimonial}
                city_slug={this.props.city_slug}
                updateTestimonialList={this.updateTestimonialList}
                closeTestimonialForm={this.closeTestimonialForm} />
            </div>
          )
        })}
        <div className='testimonial-list-item'>
          <div className={addTestimonialCardClasses} onClick={this.onAddClick}>
            <div id="testimonial-add-list-item" className="text-center">
              <i className="mdi mdi-plus" />
            </div>
          </div>
          <div className={formClasses} id="testimonial-list-form">
            <TestimonialListItemForm
              city_slug={this.props.city_slug}
              updateTestimonialList={this.updateTestimonialList}
              closeTestimonialForm={this.closeTestimonialForm}
              testimonial={null}
              alumnusDefaultPicture={this.props.alumnus_default_picture} />
          </div>
        </div>
      </div>
    );
  },
  onAddClick(e) {
    this.setState({isFormOpen: true});
  }
});
