var TestimonialList = React.createClass({
  getInitialState() {
    return {
      testimonials: this.props.testimonials
    };
  },
  updateTestimonialList: function(testimonials) {
    this.setState({testimonials: testimonials});
  },
  render: function() {
    <div class="testimonial-list">
      {this.state.testimonials.map((testimonial, index) => {
        return (
          <div className="testimonial-list-item" key={index}>
            <TestimonialListItem testimonial={testimonial} updateTestimonialList={this.updateTestimonialList} />
          </div>
        )
      })}
      <div className="testimonial-list-item">
        <div id="testimonial-add-list-item">
          <i className="mdi mdi-plus" />
        </div>
        <div className="hidden">
          <TestimonialListItemForm updateTestimonialList={this.updateTestimonialList} />
        </div>
      </div>
    </div>
  }
});
