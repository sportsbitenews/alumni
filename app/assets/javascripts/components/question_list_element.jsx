class QuestionListElement extends PostListElement {
  constructor(props) {
    super(props);
    // this.state = _.merge(this.state, {}); // Uncomment to add specific state
  }

  content() {
    return (
      <div className='post-item question-item'>
        <div className='post-item-text'>
          <div className='post-item-text-name'>
            {this.props.title}
          </div>
          <div className='post-item-text-tagline'>
            posted by
              <PopoverUser user={this.props.user} />
          </div>
        </div>
        <div className='post-item-upvote'>
          <Upvote {...this.props} />
        </div>
      </div>
    )
  }
}
