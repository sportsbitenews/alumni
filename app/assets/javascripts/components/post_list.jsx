var PostList = React.createClass({
  render: function() {
    return (
      <div ref='postList'>
        <SwipeViews>
          <div className='col-sm-3 posts-column' title="#resources">
          <a href={Routes.new_resource_path()}>
            <div className='posts-column-new'>
              ADD A NEW RESOURCE
            </div>
          </a>
            {this.props.resources.map(resource => {
              var props = _.merge(resource, { key: `${resource.type}-${resource.id}` });
              return React.createElement(ResourceListElement, props);
            })}
          </div>
          <div className='col-sm-3 posts-column' title="#help">
          <a href={Routes.new_question_path()}>
            <div className='posts-column-new'>
              ASK A NEW QUESTION
            </div>
          </a>
            {this.props.questions.map(question => {
              var props = _.merge(question, { key: `${question.type}-${question.id}` });
              return React.createElement(QuestionListElement, props);
            })}
          </div>
          <div className='col-sm-3 posts-column' title="#jobs">
            <a href={Routes.new_job_path()}>
              <div className='posts-column-new'>
                ADD A NEW JOB
              </div>
            </a>
            {this.props.jobs.map(job => {
              var props = _.merge(job, { key: `${job.type}-${job.id}` });
              return React.createElement(JobListElement, props);
            })}
          </div>
          <div className='col-sm-3 posts-column' title="#milestones">
            <div className='posts-column-new'>
              ADD A NEW MILESTONE
            </div>
          </div>
        </SwipeViews>
      </div>
    );
  }
});
