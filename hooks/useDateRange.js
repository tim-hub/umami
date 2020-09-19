import { useSelector } from 'react-redux';
import { parseISO } from 'date-fns';
import { getDateRange } from 'lib/date';
import { getItem } from 'lib/web';

export default function useDateRange(websiteId, defaultDateRange = '24hour') {
  let globalDefault = getItem('umami.date-range');

  if (!globalDefault) {
    globalDefault = {
      startDate: new Date().toISOString(),
      endDate: new Date().toISOString(),
    };
  }

  let globalDateRange;

  if (typeof globalDefault === 'string') {
    globalDateRange = getDateRange(globalDefault);
  } else {
    globalDateRange = {
      ...globalDefault,
      startDate: parseISO(globalDefault.startDate),
      endDate: parseISO(globalDefault.endDate),
    };
  }

  return useSelector(
    state =>
      state.websites[websiteId]?.dateRange || globalDateRange || getDateRange(defaultDateRange),
  );
}
