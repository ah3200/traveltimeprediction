import sys
import pandas as pd
import datetime

if __name__ == '__main__':
    
    weekend = ['03/07/2015','03/14/2015','03/21/2015','03/28/2015','04/04/2015']
    
    df = pd.read_csv(sys.argv[1])
    sortdf = df.sort(['V1','section'])
    
    sortdf['date'] = sortdf['V1'].apply(lambda x: x[:10])
    
    xsortdf = sortdf
    xsortdf = xsortdf.loc[xsortdf['date'] != '03/07/2015']
    xsortdf = xsortdf.loc[xsortdf['date'] != '03/14/2015']
    xsortdf = xsortdf.loc[xsortdf['date'] != '03/21/2015']
    xsortdf = xsortdf.loc[xsortdf['date'] != '03/28/2015']
    xsortdf = xsortdf.loc[xsortdf['date'] != '04/04/2015']
    
    output = []
    
#    timestamp = sortdf['V1'].values.tolist()
#    section = sortdf['section'].values.tolist()
#    traveltime = sortdf['traveltime'].values.tolist()

#   Group data, take only weekdays
    groupbytime = xsortdf.groupby('V1')
    
    for name, group in groupbytime:
#        print name
        cumtime = 0
        time_window = 5
        currentdatetime = datetime.datetime.strptime(name,'%m/%d/%Y %H:%M:%S')
        currentname = name
        for st in group['section'].values.tolist():
            if cumtime > time_window:
                currentdatetime = currentdatetime + datetime.timedelta(minutes = 5)
                currentname = str(currentdatetime.strftime('%m/%d/%Y %H:%M:%S'))
                time_window = time_window + 5
            ttime = sortdf['traveltime'].loc[(sortdf['V1'] == currentname) & (sortdf['section'] == st)].values.tolist()
            cumtime = cumtime + ttime[0]
        
        simpletime = group['traveltime'].sum()
        output.append([name,simpletime,cumtime])
        print name
    
    with open('traffic_cumulative_time.csv', 'w') as f:
        for n in output:
        #print n[0], n[1]
            f.write(str(n[0]) + ',' + str(n[1]) + ',' + str(n[2]) + '\n')
#   f.closed
#        traveltime = group['traveltime'].values.tolist()
#        for st in station:
#            cultime = cultime + time
#            if cultime >= time_window:
                
                           
#        print name
#        print sortgroup['section']
#        print sortgroup['traveltime']
#        cultime = group['traveltime'].sum()
#        output[name] = cultime
    
#    for i,v in output.iteritems():
#        print i, v
        
        

