class ResourceListElement extends PostListElement {
  constructor(props) {
    super(props);
    // this.state = _.merge(this.state, {});  // Uncomment to add specific state
  }

  color() {
    return "orange";
  }

  content() {
    var thumbnailStyle = {
      backgroundImage: "url('"+ this.props.screenshot_url +"');"
    }
    var tooltip = (<ReactBootstrap.Tooltip className='tooltip-resource'>{this.props.tagline}</ReactBootstrap.Tooltip>)

    return (
        <div className='post-item resource-item' ref='listItem'>
          <div className='flex resource-item-meta'>
            <div className='post-item-text'>
              <ReactBootstrap.OverlayTrigger placement='bottom' trigger={['hover', 'focus']} delayShow={200} overlay={tooltip}>
                <div className='post-item-text-name'>
                  {this.props.title}
                </div>
              </ReactBootstrap.OverlayTrigger>

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
