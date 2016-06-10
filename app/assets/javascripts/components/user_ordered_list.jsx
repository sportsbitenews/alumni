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
      'col-sm-3': this.props.inner_component_name == null
    })

    var members = this.state.members;
    members.forEach((member) => {
      member.updateMembersList = this.updateMembersList;
      if (this.props.inner_component_name !== null) {
        member.innerComponent = React.createElement(eval(this.props.inner_component_name), {
          member: member
        });
      }
    });

    return (
      <div>
        <div className="padded-1em">
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
            callback={this.reorderCallback}
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
            disableReorder={false} />
        </div>
        <div className="user-ordered-list-form">
          <UserOrederedListForm
            orderedListId={this.props.ordered_list_id}
            position={this.props.position}
            updateMembersList={this.updateMembersList} />
        </div>
      </div>
    )
  },

  reorderCallback(e) {
    var userOrderedListSlugs = _.map(this.state.members, function(member){ return member.github_nickname; });
    axios.railsPatch(
      Routes.ordered_list_path(this.props.ordered_list_id, { format: 'json' }),
      {
        member_slugs: userOrderedListSlugs,
        position: this.props.position,
        inner_component_name: this.props.inner_component_name
      }
    )
  }
});
