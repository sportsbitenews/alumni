 var UserOrderedListItem = React.createClass({
  render: function() {
    var draggableClasses = classNames({
      'teacher-draggable': this.props.item.innerComponent != null,
      'bg-white': true
    });
    return (
      <div className={draggableClasses}>
        <div className="manager-box">
          <div className="manager-avatar" onMouseDown={this.props.onMouseDown}>
            <img className="avatar" src={this.props.item.gravatar_url} alt="" />
          </div>
          <div className="manager-username">
            {this.props.item.github_nickname}
          </div>
          <button className='manager-button manager-button-kill'
              onClick={this.handleRemoveClick} >
            <i className="mdi mdi-window-close" />
          </button>
        </div>
        {this.props.item.innerComponent}
      </div>
    )
  },

  handleRemoveClick(e) {
    e.preventDefault();
    axios.railsPatch(
      Routes.ordered_list_path(this.props.item.ordered_list_id, { format: 'json' }),
      {
        'github_nickname': this.props.item.github_nickname,
        'position': this.props.item.position,
        'inner_component_name': this.props.inner_component_name,
        'remove': true
      }
    ).then((response) => {
      this.props.item.updateMembersList(response.data.members);
    });
  }
});
