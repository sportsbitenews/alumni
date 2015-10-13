class JobListElement extends PostListElement {
  constructor(props) {
    super(props);
    // this.state = _.merge(this.state, {}); // Uncomment to add specific state
  }

  content() {
    var city = this.props.city;
    if (city !== "") {
      city = `(${city})`;
    }

    return (
      <div className='post-item job-item'>
        <div className='post-item-text'>
          <div className='post-item-text-name'>
            {this.props.title} @ {this.props.company} {city}
          </div>
          <div className='post-item-text-tagline'>
            posted by
              <strong> {this.props.user.github_nickname}</strong>
          </div>
        </div>
        <div className='post-item-upvote'>
          <Upvote {...this.props} />
        </div>
      </div>
    )
  }
}
