class ResourceListElement extends PostListElement {
  constructor(props) {
    super(props);
    // this.state = _.merge(this.state, {});  // Uncomment to add specific state
  }

  content() {
    var thumbnailStyle = {
      backgroundImage: "url('"+ this.props.screenshot_url +"');"
    }

    return (
        <div className='post-item resource-item' ref='listItem'>
          <div className='flex resource-item-meta'>
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
        </div>
    )
  }
}
