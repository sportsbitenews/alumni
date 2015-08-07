class QuestionListElement extends PostListElement {
  constructor(props) {
    super(props);
    // this.state = _.merge(this.state, {}); // Uncomment to add specific state
  }

  color() {
    return "#2980b9"
  }

  content() {
    return (
      <div className='post-item'>
          <div className='post-item-upvote'>
            <Upvote {...this.props} />
          </div>
        <div className='post-item-text'>
          <div className='post-item-text-name'>
            {this.props.title}
          </div>
          <div className='post-item-text-tagline'>
            posted by {this.props.user.github_nickname}
          </div>
        </div>
      </div>
    )
  }
}
