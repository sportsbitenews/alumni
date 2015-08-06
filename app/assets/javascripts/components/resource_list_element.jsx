class ResourceListElement extends PostListElement {
  constructor(props) {
    super(props);
    // this.state = _.merge(this.state, {});  // Uncomment to add specific state
  }

  color() {
    return "orange";
  }

  content() {
    return (
      <div className='post-item resource-item'>
        <div className='resource-thumbnail'>

        </div>
        <div className='flex resource-item-meta'>
          <div className='post-item-upvote'>
            <Upvote {...this.props} />
          </div>
          <div className='post-item-text'>
            <div className='post-item-text-name'>
              {this.props.title}
            </div>
            <div className='post-item-text-tagline'>
              {this.props.tagline}
            </div>
          </div>
          <div className='post-item-menu'>
            <div>
              <img src={this.props.user.gravatar_url} className='avatar' />
            </div>
          </div>
        </div>
      </div>
    )
  }
}
