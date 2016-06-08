var UserOrderedList = React.createClass({
  getInitialState() {
    return {
      members: this.props.members
    };
  },
  updateMembersList: function(members) {
    this.setState({members: members});
  },
  render: function() {
    var membersListClasses = classNames({
      'col-xs-12': true,
      'col-sm-3': this.props.position == 'teaching_assistant'
    })

    var members = this.state.members;
    members.forEach((member) => {
      member.updateMembersList = this.updateMembersList
    });

    return (
      <div>
        <Reorder
          // The key of each object in your list to use as the element key
          itemKey='github_nickname'
          // The milliseconds to hold an item for before dragging begins
          holdTime='10'
          // The list to display
          list={members}
          // A template to display for each list item
          template={UserOrderedListItem}
          // Function that is called once a reorder has been performed
          callback={this.callback}
          // Class to be applied to the outer list element
          listClass='row'
          // Class to be applied to each list items wrapper element
          itemClass={membersListClasses}
          // A function to be called if a list item is clicked (before hold time is up)
          // itemClicked={this.itemClicked}
          // The item to be selected (adds 'selected' class)
          //selected={this.state.selected}
          // The key to compare from the selected item object with each item object
          selectedKey='uuid'
          // Allows reordering to be disabled
          disableReorder={false}/>
        <TeamMemberForm
          orderedListId={this.props.ordered_list_id}
          position={this.props.position}
          updateMembersList={this.updateMembersList} />
      </div>
    )
  }
});
