var UserOrderedList = React.createClass({
  render: function() {
    return (
      <Reorder
        // The key of each object in your list to use as the element key
        itemKey='name'
        // Lock horizontal to have a vertical list
        lock='horizontal'
        // The milliseconds to hold an item for before dragging begins
        holdTime='500'
        // The list to display
        list={[
          {name: 'Item 1'},
          {name: 'Item 2'},
          {name: 'Item 3'}
        ]}
        // A template to display for each list item
        template={ListItem}
        // Function that is called once a reorder has been performed
        callback={this.callback}
        // Class to be applied to the outer list element
        listClass='my-list'
        // Class to be applied to each list items wrapper element
        itemClass='list-item'
        // A function to be called if a list item is clicked (before hold time is up)
        itemClicked={this.itemClicked}
        // The item to be selected (adds 'selected' class)
        selected={this.state.selected}
        // The key to compare from the selected item object with each item object
        selectedKey='uuid'
        // Allows reordering to be disabled
        disableReorder={false}/>
    )
  }
});
