

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
    var popover = (<ReactBootstrap.Popover className='user-popover'> <img src={this.props.user.gravatar_url} /> {this.props.user.github_nickname} </ReactBootstrap.Popover>)
    var listItem = React.findDOMNode(this.refs.listItem)

    return (
        <div className='post-item resource-item' ref='listItem'>
          <div className='flex resource-item-meta'>

            <div className='post-item-text'>
              <ReactBootstrap.OverlayTrigger placement='bottom' trigger='hover' delayShow={200} overlay={tooltip}>
                <div className='post-item-text-name'>
                  {this.props.title}
                </div>
              </ReactBootstrap.OverlayTrigger>

              <div className='post-item-text-tagline'>
                posted by
                <ReactBootstrap.OverlayTrigger placement='bottom' trigger='hover' delayShow={200} overlay={popover}>
                  <strong> {this.props.user.github_nickname}</strong>
                </ReactBootstrap.OverlayTrigger >
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
