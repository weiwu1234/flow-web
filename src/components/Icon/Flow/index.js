import React from 'react'
import PropTypes from 'prop-types'

export default function FlowIcon ({ status, className }) {
  let iconName = ''
  switch (status) {
    case 'ENQUEUE':
      break
    case 'SUCCESS':
      iconName = 'icon-check'
      break
    case 'FAILURE':
      iconName = 'icon-warning'
      break
  }

  return <i className={`icon ${iconName} ${className}`} />
}

FlowIcon.propTypes = {
  status: PropTypes.string.isRequired,
  className: PropTypes.string,
}
