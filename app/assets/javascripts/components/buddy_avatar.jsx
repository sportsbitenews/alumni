var BuddyAvatar = React.createClass({
  render: function() {
    var tooltip = (<ReactBootstrap.Tooltip>{this.props.name}</ReactBootstrap.Tooltip>)

    return (
      <div>
        <ReactBootstrap.OverlayTrigger placement='right' trigger={['hover', 'focus']} delayShow={30} overlay={tooltip}>
          <img className="avatar" src={this.props.thumb} />
        </ReactBootstrap.OverlayTrigger>
      </div>
    );
  }
});
