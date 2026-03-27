import { useState, useCallback, useRef, useEffect } from "react";

const fontStyle = `@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap');
* { box-sizing: border-box; margin: 0; padding: 0; user-select:none; -webkit-user-select:none; }
body { font-family: 'Noto Sans KR', -apple-system, sans-serif; }
button { font-family: inherit; }`;

const C = {
  primary:'#0064FF', primaryBg:'#E8F0FE',
  bg:'#FFFFFF', surface:'#FFFFFF', surfaceVariant:'#F4F4F5',
  text:'#191F28', textSub:'#8B95A1', textTertiary:'#B0B8C1',
  border:'#E5E8EB', borderLight:'#F2F4F6',
  sunday:'#FF3B30', saturday:'#0064FF',
  success:'#00C853', warning:'#FF9100', error:'#FF3B30',
};

const SHIFTS = {
  MD: { id:'MD', name:'오전 근무', abbr:'오전', color:'#0064FF', bg:'#E8F0FE', time:'09:00-18:00' },
  AF: { id:'AF', name:'오후 근무', abbr:'오후', color:'#FF9100', bg:'#FFF3E0', time:'14:00-22:00' },
  NI: { id:'NI', name:'야간 근무', abbr:'야간', color:'#6C5CE7', bg:'#F0EDFF', time:'22:00-07:00' },
  HD: { id:'HD', name:'휴무',     abbr:'휴무', color:'#94A3B8', bg:'#F1F5F9', time:null },
  E:  { id:'E',  name:'이브닝',   abbr:'이브닝',color:'#00B894', bg:'#E6F9F3', time:'17:00-00:00' },
};

// 나(김민수) = id:'1'
const ME = { id:'1', name:'김민수', init:'민', color:'#0064FF' };
const MEMBERS = [
  ME,
  { id:'2', name:'이서연', init:'서', color:'#6C5CE7' },
  { id:'3', name:'박지훈', init:'훈', color:'#00B894' },
  { id:'4', name:'최수영', init:'수', color:'#FF9100' },
];

const EVENTS = [
  { id:'e1', title:'안전교육', s:15, e:15, color:'#FF3B30', memo:'전 직원 필수 참석' },
  { id:'e2', title:'워크숍',   s:20, e:21, color:'#00B894', memo:'' },
];

const YEAR=2026, MONTH=3, TODAY=26;
const DAYS = new Date(YEAR, MONTH, 0).getDate();

// 팀원 나머지 3명 고정 데이터
const OTHER_PATTERNS = {
  '2':['AF','NI','NI','HD','MD','AF','MD','NI','AF','AF'],
  '3':['NI','MD','HD','MD','AF','NI','HD','AF','MD','NI'],
  '4':['HD','AF','MD','AF','NI','HD','MD','AF','NI','MD'],
};
const OTHER_ASSIGN = {};
['2','3','4'].forEach(id => {
  const p=OTHER_PATTERNS[id], obj={};
  for(let d=1;d<=DAYS;d++) obj[d]=p[(d-1)%p.length];
  OTHER_ASSIGN[id]=obj;
});

const MY_INIT_PATTERN = ['MD','MD','AF','NI','HD','MD','AF','MD','NI','MD'];
const initMySchedule = () => {
  const obj={};
  for(let d=1;d<=19;d++) obj[d]=MY_INIT_PATTERN[(d-1)%MY_INIT_PATTERN.length];
  return obj;
};

const DOW=['일','월','화','수','목','금','토'];
const firstDow = () => new Date(YEAR,MONTH-1,1).getDay();
const dayDow = d => new Date(YEAR,MONTH-1,d).getDay();

function buildGrid() {
  const cells=[];
  for(let i=0;i<firstDow();i++) cells.push(null);
  for(let d=1;d<=DAYS;d++) cells.push(d);
  while(cells.length%7!==0) cells.push(null);
  return cells;
}
const GRID = buildGrid();

// teamAssign: 나의 최신 제출 데이터 + 팀원 고정 데이터 합산
function getTeamAssign(mySubmitted) {
  const result = { ...OTHER_ASSIGN };
  result['1'] = mySubmitted || {};
  return result;
}

function getDaySummary(day, teamAssign) {
  const r={};
  MEMBERS.forEach(m => {
    const s=teamAssign[m.id]?.[day];
    if(!s) return;
    if(!r[s]) r[s]=[];
    r[s].push(m.name);
  });
  return r;
}

// ── 공통 컴포넌트 ──
function ShiftBadge({ id, size='sm' }) {
  const s=SHIFTS[id]; if(!s) return null;
  const fs=size==='lg'?13:size==='md'?11:9;
  const px=size==='lg'?7:size==='md'?6:4;
  const py=size==='lg'?3:size==='md'?2:1;
  return (
    <span style={{ display:'inline-block', background:s.bg, color:s.color,
      fontSize:fs, fontWeight:700, padding:`${py}px ${px}px`, borderRadius:4, lineHeight:1.3 }}>
      {s.abbr}
    </span>
  );
}
function Avatar({ m, size=32 }) {
  return (
    <div style={{ width:size,height:size,borderRadius:'50%',background:m.color,
      display:'flex',alignItems:'center',justifyContent:'center',
      color:'#fff',fontSize:size*0.38,fontWeight:700,flexShrink:0 }}>
      {m.init}
    </div>
  );
}
function WeekdayHeader() {
  return (
    <div style={{ display:'grid',gridTemplateColumns:'repeat(7,1fr)',
      borderBottom:`1px solid ${C.borderLight}` }}>
      {DOW.map((d,i)=>(
        <div key={d} style={{ textAlign:'center',padding:'8px 0',fontSize:11,fontWeight:600,
          color:i===0?C.sunday:i===6?C.saturday:C.textSub }}>{d}</div>
      ))}
    </div>
  );
}
function MonthNav() {
  return (
    <div style={{ display:'flex',alignItems:'center',justifyContent:'center',gap:16 }}>
      <NavBtn dir="◀"/><span style={{ fontSize:15,fontWeight:600,color:C.text }}>2026년 3월</span><NavBtn dir="▶"/>
    </div>
  );
}
function NavBtn({ dir, onClick }) {
  return <button onClick={onClick} style={{ background:'none',border:'none',cursor:'pointer',
    color:C.textSub,fontSize:15,padding:'4px 8px',borderRadius:6 }}>{dir}</button>;
}
function EmptyCell() {
  return <div style={{ minHeight:60,borderBottom:`1px solid ${C.borderLight}`,
    borderRight:`1px solid ${C.borderLight}`,background:C.surfaceVariant }}/>;
}
function DayNum({ n, isToday, dow }) {
  return (
    <div style={{ width:22,height:22,display:'flex',alignItems:'center',justifyContent:'center',
      borderRadius:'50%',fontSize:11,fontWeight:isToday?700:500,
      background:isToday?C.primary:'transparent',
      color:isToday?'#fff':dow===0?C.sunday:dow===6?C.saturday:C.text }}>
      {n}
    </div>
  );
}
function TogglePill({ options, value, onChange }) {
  return (
    <div style={{ display:'flex',background:C.surfaceVariant,borderRadius:8,padding:2 }}>
      {options.map(o=>(
        <button key={o.v} onClick={()=>onChange(o.v)} style={{
          padding:'5px 12px',borderRadius:6,border:'none',cursor:'pointer',
          background:value===o.v?C.surface:'transparent',
          color:value===o.v?C.primary:C.textSub,
          fontSize:12,fontWeight:600,
          boxShadow:value===o.v?'0 1px 3px rgba(0,0,0,0.1)':'none',
          transition:'all 0.15s' }}>{o.l}</button>
      ))}
    </div>
  );
}
function SubScreen({ title, onBack, right, children }) {
  return (
    <div style={{ display:'flex',flexDirection:'column',height:'100%' }}>
      <div style={{ padding:'14px 20px 12px',borderBottom:`1px solid ${C.borderLight}`,
        display:'flex',alignItems:'center',justifyContent:'space-between' }}>
        <div style={{ display:'flex',alignItems:'center',gap:10 }}>
          <button onClick={onBack} style={{ background:'none',border:'none',cursor:'pointer',
            fontSize:22,color:C.text,lineHeight:1,padding:'0 6px 0 0' }}>←</button>
          <span style={{ fontSize:17,fontWeight:700,color:C.text }}>{title}</span>
        </div>
        {right}
      </div>
      <div style={{ flex:1,overflow:'auto' }}>{children}</div>
    </div>
  );
}
function ActionBtn({ label, bg, color, full, onClick }) {
  return (
    <button onClick={onClick} style={{ flex:full?1:undefined,padding:'7px 14px',
      background:bg,color,border:'none',borderRadius:8,fontSize:12,fontWeight:700,cursor:'pointer' }}>
      {label}
    </button>
  );
}

// ═══════════════════════════════════════════════════════════
// SHARED CALENDAR
// ═══════════════════════════════════════════════════════════
function SharedCalendarScreen({ submittedAssign }) {
  const [view,setView]       = useState('monthly');
  const [wStart,setWStart]   = useState(1);
  const [detailDay,setDetail]= useState(null);

  // submittedAssign: 제출된 나의 근무 (null이면 미제출)
  const teamAssign = getTeamAssign(submittedAssign);
  const isMySubmitted = !!submittedAssign;

  return (
    <div style={{ display:'flex',flexDirection:'column',height:'100%' }}>
      <style>{fontStyle}</style>
      <div style={{ padding:'14px 20px 10px',borderBottom:`1px solid ${C.borderLight}` }}>
        <div style={{ display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:10 }}>
          <span style={{ fontSize:18,fontWeight:700,color:C.text }}>캘린더</span>
          <TogglePill options={[{v:'monthly',l:'월간'},{v:'weekly',l:'주간'}]} value={view} onChange={setView}/>
        </div>
        <MonthNav/>
      </div>

      {/* 제출 상태 배너 */}
      {isMySubmitted ? (
        <div style={{ padding:'8px 16px',background:'#F0FFF6',borderBottom:`1px solid #C7F0D5`,
          display:'flex',alignItems:'center',gap:6 }}>
          <span style={{ fontSize:13 }}>✅</span>
          <span style={{ fontSize:12,fontWeight:600,color:C.success }}>
            내 근무가 팀 캘린더에 반영되었습니다
          </span>
        </div>
      ) : (
        <div style={{ padding:'8px 16px',background:'#FFFBF0',borderBottom:`1px solid #FFE9A0`,
          display:'flex',alignItems:'center',gap:6 }}>
          <span style={{ fontSize:13 }}>⏳</span>
          <span style={{ fontSize:12,fontWeight:600,color:C.warning }}>
            아직 근무를 제출하지 않았습니다. 내 근무는 반영되지 않아요.
          </span>
        </div>
      )}

      <div style={{ flex:1,overflow:'auto' }}>
        {view==='monthly'
          ? <MonthlyView teamAssign={teamAssign} onDayTap={setDetail}/>
          : <WeeklyView  teamAssign={teamAssign} wStart={wStart} onWChange={setWStart}/>}
      </div>
      {detailDay && (
        <DayDetailSheet day={detailDay} teamAssign={teamAssign} onClose={()=>setDetail(null)}/>
      )}
    </div>
  );
}

function MonthlyView({ teamAssign, onDayTap }) {
  return (
    <>
      <WeekdayHeader/>
      <div style={{ display:'grid',gridTemplateColumns:'repeat(7,1fr)' }}>
        {GRID.map((day,idx) => {
          if(!day) return <EmptyCell key={`e${idx}`}/>;
          const dow=idx%7, isToday=day===TODAY;
          const summary=getDaySummary(day,teamAssign);
          const evts=EVENTS.filter(e=>day>=e.s&&day<=e.e);
          return (
            <div key={day} onClick={()=>onDayTap(day)} style={{
              minHeight:76,padding:4,cursor:'pointer',
              borderBottom:`1px solid ${C.borderLight}`,
              borderRight:`1px solid ${C.borderLight}`,
              background:isToday?'#F0F6FF':C.bg,
            }}>
              <DayNum n={day} isToday={isToday} dow={dow}/>
              <div style={{ display:'flex',flexWrap:'wrap',gap:2,marginTop:3 }}>
                {Object.entries(summary).map(([sid,names])=>(
                  <div key={sid} style={{ display:'flex',alignItems:'center',gap:1 }}>
                    <ShiftBadge id={sid}/>
                    <span style={{ fontSize:9,color:C.textSub,fontWeight:600 }}>{names.length}</span>
                  </div>
                ))}
              </div>
              {evts.map(e=>(
                <div key={e.id} style={{ marginTop:2,fontSize:8,fontWeight:700,color:e.color,
                  background:`${e.color}18`,borderRadius:3,padding:'1px 3px',
                  overflow:'hidden',textOverflow:'ellipsis',whiteSpace:'nowrap' }}>
                  📌{e.title}
                </div>
              ))}
            </div>
          );
        })}
      </div>
    </>
  );
}

function WeeklyView({ teamAssign, wStart, onWChange }) {
  const last=Math.min(wStart+6,DAYS);
  return (
    <div style={{ overflow:'auto' }}>
      <div style={{ display:'flex',alignItems:'center',justifyContent:'center',gap:12,
        padding:'10px 20px',borderBottom:`1px solid ${C.borderLight}` }}>
        <NavBtn onClick={()=>onWChange(Math.max(1,wStart-7))} dir="◀"/>
        <span style={{ fontSize:13,fontWeight:600,color:C.text }}>3월 {wStart}일 ~ {last}일</span>
        <NavBtn onClick={()=>onWChange(Math.min(DAYS-6,wStart+7))} dir="▶"/>
      </div>
      <div style={{ display:'grid',gridTemplateColumns:'62px repeat(7,1fr)',
        background:C.surfaceVariant,borderBottom:`1px solid ${C.border}` }}>
        <div style={{ padding:'8px 6px',fontSize:10,fontWeight:600,color:C.textSub,textAlign:'center' }}>이름</div>
        {Array.from({length:7},(_,i)=>{
          const d=wStart+i; if(d>DAYS) return <div key={i}/>;
          const w=dayDow(d);
          return (
            <div key={i} style={{ padding:'4px 2px',textAlign:'center' }}>
              <div style={{ fontSize:9,fontWeight:600,color:w===0?C.sunday:w===6?C.saturday:C.textSub }}>{DOW[w]}</div>
              <div style={{ fontSize:13,fontWeight:700,color:w===0?C.sunday:w===6?C.saturday:C.text }}>{d}</div>
            </div>
          );
        })}
      </div>
      {MEMBERS.map(m=>(
        <div key={m.id} style={{ display:'grid',gridTemplateColumns:'62px repeat(7,1fr)',
          borderBottom:`1px solid ${C.borderLight}`,
          background: m.id===ME.id ? '#FAFCFF' : C.bg }}>
          <div style={{ display:'flex',alignItems:'center',gap:6,padding:'8px 8px' }}>
            <Avatar m={m} size={26}/>
            <span style={{ fontSize:11,fontWeight:m.id===ME.id?700:600,
              color:m.id===ME.id?C.primary:C.text }}>{m.name.slice(1)}</span>
          </div>
          {Array.from({length:7},(_,i)=>{
            const d=wStart+i; if(d>DAYS) return <div key={i}/>;
            const sid=teamAssign[m.id]?.[d];
            return (
              <div key={i} style={{ display:'flex',alignItems:'center',justifyContent:'center',minHeight:46 }}>
                {sid
                  ? <ShiftBadge id={sid} size="md"/>
                  : <span style={{ color:m.id===ME.id?`${C.warning}60`:C.borderLight,fontSize:10 }}>
                      {m.id===ME.id?'미제출':'-'}
                    </span>}
              </div>
            );
          })}
        </div>
      ))}
    </div>
  );
}

function DayDetailSheet({ day, teamAssign, onClose }) {
  const summary=getDaySummary(day,teamAssign);
  const w=dayDow(day);
  const evts=EVENTS.filter(e=>day>=e.s&&day<=e.e);
  return (
    <div style={{ position:'absolute',inset:0,zIndex:50 }} onClick={onClose}>
      <div style={{ position:'absolute',inset:0,background:'rgba(0,0,0,0.28)',backdropFilter:'blur(2px)' }}/>
      <div onClick={e=>e.stopPropagation()} style={{
        position:'absolute',bottom:0,left:0,right:0,
        background:C.surface,borderRadius:'24px 24px 0 0',
        padding:'10px 20px 36px',
        boxShadow:'0 -8px 30px rgba(0,0,0,0.14)',
        maxHeight:'72%',overflow:'auto',
      }}>
        <div style={{ width:36,height:4,background:C.border,borderRadius:2,margin:'0 auto 14px' }}/>
        <h3 style={{ fontSize:16,fontWeight:700,color:C.text,marginBottom:14 }}>
          3월 {day}일 ({DOW[w]}) 근무 현황
        </h3>
        {Object.keys(summary).length===0 && (
          <div style={{ fontSize:13,color:C.textSub,textAlign:'center',padding:'20px 0' }}>
            등록된 근무가 없습니다
          </div>
        )}
        {Object.entries(summary).map(([sid,names])=>{
          const s=SHIFTS[sid]; if(!s) return null;
          return (
            <div key={sid} style={{ marginBottom:10,padding:'12px 14px',background:s.bg,borderRadius:12 }}>
              <div style={{ display:'flex',alignItems:'center',gap:8,marginBottom:5 }}>
                <ShiftBadge id={sid} size="md"/>
                <span style={{ fontSize:13,fontWeight:600,color:s.color }}>{s.name}</span>
                {s.time&&<span style={{ fontSize:11,color:s.color,opacity:0.7 }}>{s.time}</span>}
                <span style={{ fontSize:12,color:C.textSub,marginLeft:'auto',fontWeight:600 }}>{names.length}명</span>
              </div>
              <div style={{ fontSize:12,color:C.textSub }}>{names.join(', ')}</div>
            </div>
          );
        })}
        {evts.map(e=>(
          <div key={e.id} style={{ marginTop:6,padding:'10px 14px',background:`${e.color}12`,
            borderRadius:10,borderLeft:`3px solid ${e.color}` }}>
            <div style={{ fontSize:12,fontWeight:700,color:e.color }}>📌 이벤트: {e.title}</div>
            {e.memo&&<div style={{ fontSize:11,color:C.textSub,marginTop:3 }}>{e.memo}</div>}
          </div>
        ))}
      </div>
    </div>
  );
}

// ═══════════════════════════════════════════════════════════
// WORKER CALENDAR — Paint Mode
// ═══════════════════════════════════════════════════════════
function WorkerCalendarScreen({ onSubmit, submittedAssign }) {
  const [selShift,setSel]    = useState('MD');
  const [assign,setAssign]   = useState(initMySchedule);
  const [showConfirm,setShowConfirm] = useState(false);

  const paintMode = true;
  const submitted = !!submittedAssign;
  const displayAssign = submitted ? submittedAssign : assign;

  const isPainting = useRef(false);
  const paintedInStroke = useRef(new Set());

  const count  = Object.keys(assign).length;
  const pct    = Math.round((count/DAYS)*100);
  const pctColor = pct<50?C.warning:pct<100?C.primary:C.success;

  const paintDay = useCallback((day) => {
    if(!paintMode||submitted||!day) return;
    if(paintedInStroke.current.has(day)) return;
    paintedInStroke.current.add(day);
    setAssign(prev=>{
      const next={...prev};
      if(selShift==='ERASER') delete next[day];
      else next[day]=selShift;
      return next;
    });
  },[paintMode,selShift,submitted]);

  const startPaint = useCallback((day)=>{
    if(!paintMode||submitted) return;
    isPainting.current=true;
    paintedInStroke.current=new Set();
    paintDay(day);
  },[paintMode,submitted,paintDay]);

  const endPaint = useCallback(()=>{
    isPainting.current=false;
    paintedInStroke.current=new Set();
  },[]);

  const enterDay = useCallback((day)=>{
    if(isPainting.current) paintDay(day);
  },[paintDay]);

  useEffect(()=>{
    window.addEventListener('mouseup',endPaint);
    window.addEventListener('touchend',endPaint);
    return ()=>{ window.removeEventListener('mouseup',endPaint); window.removeEventListener('touchend',endPaint); };
  },[endPaint]);

  const curShift = selShift!=='ERASER' ? SHIFTS[selShift] : null;

  const handleSubmitConfirm = () => {
    const now = new Date();
    onSubmit({ ...assign }, now);
    setShowConfirm(false);
    setPaint(false);
  };

  return (
    <div style={{ display:'flex',flexDirection:'column',height:'100%' }}>
      {/* AppBar */}
      <div style={{ padding:'14px 20px 10px',borderBottom:`1px solid ${C.borderLight}` }}>
        <div style={{ display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:10 }}>
          <div style={{ display:'flex',alignItems:'center',gap:8 }}>
            {paintMode&&<span style={{ fontSize:16 }}>✏️</span>}
            <span style={{ fontSize:18,fontWeight:700,color:C.text }}>근무신청</span>
          </div>

        </div>
        <MonthNav/>
      </div>

      {/* 안내 배너 */}
      {paintMode&&!submitted&&(
        <div style={{ padding:'8px 16px',background:curShift?curShift.bg:'#FFF0EF',
          borderBottom:`1px solid ${C.borderLight}`,display:'flex',alignItems:'center',gap:8 }}>
          <div style={{ width:8,height:8,borderRadius:'50%',background:curShift?curShift.color:C.error }}/>
          <span style={{ fontSize:12,fontWeight:600,color:curShift?curShift.color:C.error }}>
            {curShift?`${curShift.name} 선택됨 — 탭하거나 드래그해서 등록`:'지우개 모드 — 탭/드래그해서 삭제'}
          </span>
        </div>
      )}

      {/* Calendar */}
      <div style={{ flex:1,overflow:'auto' }}>
        <WeekdayHeader/>
        <div style={{ display:'grid',gridTemplateColumns:'repeat(7,1fr)' }}>
          {GRID.map((day,idx)=>{
            if(!day) return <EmptyCell key={`e${idx}`}/>;
            const dow=idx%7, isToday=day===TODAY;
            const sid=displayAssign[day];
            const s=sid?SHIFTS[sid]:null;
            return (
              <div key={day}
                onMouseDown={()=>startPaint(day)}
                onMouseEnter={()=>enterDay(day)}
                onTouchStart={e=>{ e.preventDefault(); startPaint(day); }}
                onTouchMove={e=>{
                  e.preventDefault();
                  const t=e.touches[0];
                  const el=document.elementFromPoint(t.clientX,t.clientY);
                  if(el?.dataset?.day) enterDay(Number(el.dataset.day));
                }}
                data-day={day}
                style={{
                  minHeight:60,padding:'4px 3px',
                  cursor:paintMode&&!submitted?'crosshair':'default',
                  borderBottom:`1px solid ${C.borderLight}`,
                  borderRight:`1px solid ${C.borderLight}`,
                  background:s?s.bg:isToday?'#F0F6FF':C.bg,
                  transition:'background 0.08s',touchAction:'none',
                }}>
                <DayNum n={day} isToday={isToday} dow={dow}/>
                {s&&(
                  <div style={{ marginTop:3,display:'flex',justifyContent:'center' }}>
                    <ShiftBadge id={sid} size="md"/>
                  </div>
                )}
              </div>
            );
          })}
        </div>
      </div>

      {/* Bottom */}
      {submitted ? (
        <SubmittedBar submittedAt={submittedAssign.__submittedAt} days={DAYS}/>
      ) : (
        <div style={{ borderTop:`1px solid ${C.borderLight}`,background:C.surface,flexShrink:0 }}>
          {paintMode&&(
            <div style={{ padding:'12px 16px 10px',borderBottom:`1px solid ${C.borderLight}` }}>
              <div style={{ display:'flex',gap:10,justifyContent:'center',alignItems:'flex-end' }}>
                {Object.values(SHIFTS).map(s=>(
                  <ShiftPickBtn key={s.id} shift={s} selected={selShift===s.id} onSelect={setSel}/>
                ))}
                <div style={{ display:'flex',flexDirection:'column',alignItems:'center',gap:4 }}>
                  <button onClick={()=>setSel('ERASER')} style={{
                    width:52,height:52,borderRadius:14,flexShrink:0,cursor:'pointer',
                    border:`2px solid ${selShift==='ERASER'?C.error:C.borderLight}`,
                    background:selShift==='ERASER'?'#FFF0EF':C.surfaceVariant,fontSize:22,
                    transform:selShift==='ERASER'?'scale(1.1)':'scale(1)',transition:'all 0.15s',
                    boxShadow:selShift==='ERASER'?`0 0 0 3px ${C.error}30`:'none',
                  }}>🧹</button>
                  <span style={{ fontSize:10,fontWeight:600,color:selShift==='ERASER'?C.error:C.textSub }}>지우개</span>
                </div>
              </div>
            </div>
          )}
          <div style={{ padding:'12px 16px' }}>
            <div style={{ display:'flex',justifyContent:'space-between',marginBottom:5 }}>
              <span style={{ fontSize:12,color:C.textSub }}>작성 현황: {count}/{DAYS}일</span>
              <span style={{ fontSize:12,fontWeight:700,color:pctColor }}>{pct}%</span>
            </div>
            <div style={{ height:5,background:`${pctColor}20`,borderRadius:3,marginBottom:12 }}>
              <div style={{ height:'100%',width:`${pct}%`,background:pctColor,borderRadius:3,transition:'width 0.15s' }}/>
            </div>
            <button onClick={()=>pct===100&&setShowConfirm(true)} style={{
              width:'100%',padding:'13px',borderRadius:12,border:'none',
              background:pct===100?C.primary:C.surfaceVariant,
              color:pct===100?'#fff':C.textTertiary,
              fontSize:14,fontWeight:700,
              cursor:pct===100?'pointer':'default',
              transition:'background 0.2s, color 0.2s',
            }}>
              제출하기 {pct<100?`(${pct}%)`:''}
            </button>
          </div>
        </div>
      )}

      {/* 제출 확인 모달 */}
      {showConfirm&&(
        <SubmitConfirmModal
          onConfirm={handleSubmitConfirm}
          onCancel={()=>setShowConfirm(false)}
        />
      )}
    </div>
  );
}

function SubmitConfirmModal({ onConfirm, onCancel }) {
  return (
    <div style={{ position:'absolute',inset:0,zIndex:60,display:'flex',alignItems:'center',justifyContent:'center' }}
      onClick={onCancel}>
      <div style={{ position:'absolute',inset:0,background:'rgba(0,0,0,0.4)',backdropFilter:'blur(3px)' }}/>
      <div onClick={e=>e.stopPropagation()} style={{
        background:C.surface,borderRadius:20,padding:'28px 24px',margin:20,
        zIndex:1,boxShadow:'0 8px 40px rgba(0,0,0,0.2)',maxWidth:320,width:'100%',
      }}>
        <div style={{ fontSize:32,textAlign:'center',marginBottom:12 }}>📤</div>
        <h3 style={{ fontSize:17,fontWeight:700,color:C.text,textAlign:'center',marginBottom:8 }}>
          근무를 제출할까요?
        </h3>
        <p style={{ fontSize:13,color:C.textSub,textAlign:'center',lineHeight:1.6,marginBottom:20 }}>
          제출하면 팀 공유 캘린더에 즉시 반영됩니다.<br/>
          제출 후에는 수정이 불가하며, 매니저의 반려 시에만 재작성할 수 있어요.
        </p>
        <div style={{ display:'flex',gap:10 }}>
          <button onClick={onCancel} style={{ flex:1,padding:12,borderRadius:12,
            border:`1.5px solid ${C.border}`,background:C.surface,
            fontSize:14,fontWeight:600,color:C.textSub,cursor:'pointer' }}>취소</button>
          <button onClick={onConfirm} style={{ flex:1,padding:12,borderRadius:12,
            border:'none',background:C.primary,
            fontSize:14,fontWeight:700,color:'#fff',cursor:'pointer' }}>제출하기</button>
        </div>
      </div>
    </div>
  );
}

function ShiftPickBtn({ shift:s, selected, onSelect }) {
  return (
    <div style={{ display:'flex',flexDirection:'column',alignItems:'center',gap:4 }}>
      <button onClick={()=>onSelect(s.id)} style={{
        width:52,height:52,borderRadius:14,flexShrink:0,cursor:'pointer',
        border:`2px solid ${selected?s.color:'transparent'}`,
        background:s.bg,
        transform:selected?'scale(1.1)':'scale(1)',
        boxShadow:selected?`0 0 0 3px ${s.color}30`:'none',
        transition:'all 0.15s',
        display:'flex',alignItems:'center',justifyContent:'center',
      }}>
        <span style={{ fontSize:12,fontWeight:800,color:s.color }}>{s.abbr}</span>
      </button>
      <span style={{ fontSize:10,fontWeight:600,color:selected?s.color:C.textSub,transition:'color 0.15s' }}>
        {s.name.replace(' 근무','')}
      </span>
    </div>
  );
}

function SubmittedBar({ submittedAt, days }) {
  const timeStr = submittedAt
    ? `${submittedAt.getMonth()+1}/${submittedAt.getDate()} ${String(submittedAt.getHours()).padStart(2,'0')}:${String(submittedAt.getMinutes()).padStart(2,'0')}`
    : '2026-03-15 14:30';
  return (
    <div style={{ padding:'14px 16px',borderTop:`1px solid ${C.borderLight}`,background:'#F0FFF6' }}>
      <div style={{ display:'flex',alignItems:'center',gap:8,marginBottom:4 }}>
        <span style={{ fontSize:18 }}>✅</span>
        <span style={{ fontSize:15,fontWeight:700,color:C.success }}>제출 완료</span>
      </div>
      <div style={{ fontSize:12,color:C.textSub,marginBottom:8 }}>제출일: {timeStr}</div>
      <div style={{ height:4,background:`${C.success}20`,borderRadius:2 }}>
        <div style={{ height:'100%',width:'100%',background:C.success,borderRadius:2 }}/>
      </div>
      <div style={{ fontSize:11,color:C.textSub,marginTop:6,textAlign:'center' }}>
        홈 탭에서 팀 캘린더에 반영된 내 근무를 확인해보세요 →
      </div>
    </div>
  );
}

// ═══════════════════════════════════════════════════════════
// SETTINGS
// ═══════════════════════════════════════════════════════════
function SettingsScreen() {
  const [sub,setSub]=useState(null);
  if(sub==='team')       return <TeamCalendarScreen onBack={()=>setSub(null)}/>;
  if(sub==='shifttypes') return <ShiftTypesScreen   onBack={()=>setSub(null)}/>;
  if(sub==='vacation')   return <VacationScreen     onBack={()=>setSub(null)}/>;
  if(sub==='events')     return <EventsScreen       onBack={()=>setSub(null)}/>;
  const items=[
    {k:'team',       icon:'📋',label:'팀 캘린더',    desc:'팀원 스케줄 및 승인 관리'},
    {k:'shifttypes', icon:'📝',label:'근무타입 관리', desc:'근무타입 추가/수정/삭제'},
    {k:'vacation',   icon:'🏖️',label:'휴가 MAX 설정',desc:'일일 최대 휴가 인원 설정'},
    {k:'events',     icon:'📅',label:'이벤트 관리',  desc:'팀 이벤트 등록 및 관리'},
  ];
  return (
    <div style={{ display:'flex',flexDirection:'column',height:'100%' }}>
      <div style={{ padding:'14px 20px 12px',borderBottom:`1px solid ${C.borderLight}` }}>
        <span style={{ fontSize:18,fontWeight:700,color:C.text }}>설정</span>
      </div>
      <div style={{ flex:1,overflow:'auto',padding:16 }}>
        <div style={{ background:C.surface,borderRadius:16,border:`1px solid ${C.borderLight}`,overflow:'hidden' }}>
          {items.map((item,i)=>(
            <div key={item.k} onClick={()=>setSub(item.k)} style={{
              display:'flex',alignItems:'center',padding:'15px 16px',cursor:'pointer',
              borderBottom:i<items.length-1?`1px solid ${C.borderLight}`:'none' }}>
              <span style={{ fontSize:20,marginRight:12 }}>{item.icon}</span>
              <div style={{ flex:1 }}>
                <div style={{ fontSize:14,fontWeight:600,color:C.text }}>{item.label}</div>
                <div style={{ fontSize:12,color:C.textSub,marginTop:2 }}>{item.desc}</div>
              </div>
              <span style={{ color:C.textTertiary,fontSize:18 }}>›</span>
            </div>
          ))}
        </div>
        <div style={{ marginTop:16,background:C.surface,borderRadius:16,border:`1px solid ${C.borderLight}`,padding:16 }}>
          <div style={{ display:'flex',alignItems:'center',gap:12 }}>
            <Avatar m={MEMBERS[0]} size={44}/>
            <div>
              <div style={{ fontSize:15,fontWeight:700,color:C.text }}>김민수</div>
              <div style={{ fontSize:12,color:C.textSub }}>Worker · 삼성 강북점</div>
            </div>
            <div style={{ marginLeft:'auto',fontSize:11,fontWeight:600,color:C.primary,
              background:C.primaryBg,padding:'4px 10px',borderRadius:20 }}>Worker</div>
          </div>
        </div>
      </div>
    </div>
  );
}

function TeamCalendarScreen({ onBack }) {
  const [sel,setSel]=useState(null);
  const statuses=[
    {...MEMBERS[0],st:'submitted',pct:100},
    {...MEMBERS[1],st:'draft',pct:73},
    {...MEMBERS[2],st:'draft',pct:45},
    {...MEMBERS[3],st:'none',pct:0},
  ];
  if(sel) return <MemberScheduleScreen m={sel} onBack={()=>setSel(null)}/>;
  return (
    <SubScreen title="팀 캘린더" onBack={onBack}>
      <div style={{ display:'flex',flexDirection:'column',gap:10,padding:'12px 16px 16px' }}>
        {statuses.map(m=>(
          <div key={m.id} onClick={()=>setSel(m)} style={{ background:C.surface,
            border:`1px solid ${C.borderLight}`,borderRadius:16,padding:'14px 16px',cursor:'pointer' }}>
            <div style={{ display:'flex',alignItems:'center',gap:12 }}>
              <Avatar m={m} size={40}/>
              <div style={{ flex:1 }}>
                <div style={{ fontSize:14,fontWeight:700,color:C.text }}>{m.name}</div>
                {m.st==='submitted'&&<div style={{ fontSize:12,color:C.success,marginTop:2 }}>✅ 제출 완료</div>}
                {m.st==='draft'    &&<div style={{ fontSize:12,color:C.warning,marginTop:2 }}>🔄 작성중 {m.pct}%</div>}
                {m.st==='none'     &&<div style={{ fontSize:12,color:C.textSub,marginTop:2 }}>⬜ 미작성</div>}
              </div>
              {m.st==='submitted'&&(
                <div style={{ display:'flex',gap:6 }} onClick={e=>e.stopPropagation()}>
                  <ActionBtn label="승인" bg="#E8F9EF" color={C.success}/>
                  <ActionBtn label="반려" bg="#FFF0EF" color={C.error}/>
                </div>
              )}
            </div>
            {m.pct>0&&(
              <div style={{ marginTop:10 }}>
                <div style={{ height:3,background:`${m.st==='submitted'?C.success:C.warning}20`,borderRadius:2 }}>
                  <div style={{ height:'100%',width:`${m.pct}%`,background:m.st==='submitted'?C.success:C.warning,borderRadius:2 }}/>
                </div>
              </div>
            )}
          </div>
        ))}
      </div>
    </SubScreen>
  );
}

function MemberScheduleScreen({ m, onBack }) {
  const teamAssign=getTeamAssign(null);
  return (
    <SubScreen title={`${m.name} 스케줄`} onBack={onBack}>
      <div style={{ padding:'0 16px 16px' }}>
        <WeekdayHeader/>
        <div style={{ display:'grid',gridTemplateColumns:'repeat(7,1fr)',
          border:`1px solid ${C.borderLight}`,borderRadius:12,overflow:'hidden' }}>
          {GRID.map((day,idx)=>{
            if(!day) return <div key={`e${idx}`} style={{ minHeight:48,background:C.surfaceVariant,
              borderRight:`1px solid ${C.borderLight}`,borderBottom:`1px solid ${C.borderLight}` }}/>;
            const dow=idx%7,isToday=day===TODAY;
            const sid=teamAssign[m.id]?.[day];
            const s=sid?SHIFTS[sid]:null;
            return (
              <div key={day} style={{ minHeight:50,padding:3,
                borderBottom:`1px solid ${C.borderLight}`,borderRight:`1px solid ${C.borderLight}`,
                background:s?s.bg:isToday?'#F0F6FF':C.bg }}>
                <DayNum n={day} isToday={isToday} dow={dow}/>
                {s&&<div style={{marginTop:1}}><ShiftBadge id={sid}/></div>}
              </div>
            );
          })}
        </div>
        <div style={{ marginTop:12,padding:'12px 14px',background:C.primaryBg,borderRadius:12,
          display:'flex',alignItems:'center',justifyContent:'space-between' }}>
          <span style={{ fontSize:13,fontWeight:600,color:C.text }}>상태: ✅ 제출 완료</span>
          <span style={{ fontSize:11,color:C.textSub }}>3/15 제출</span>
        </div>
        <div style={{ display:'flex',gap:10,marginTop:10 }}>
          <ActionBtn label="승인" bg="#E8F9EF" color={C.success} full/>
          <ActionBtn label="반려" bg="#FFF0EF" color={C.error} full/>
        </div>
      </div>
    </SubScreen>
  );
}

function ShiftTypesScreen({ onBack }) {
  const [showForm,setShowForm]=useState(false);
  return (
    <SubScreen title="근무타입 관리" onBack={onBack}
      right={<button onClick={()=>setShowForm(true)} style={{ background:C.primary,color:'#fff',border:'none',
        borderRadius:8,padding:'6px 14px',fontSize:13,fontWeight:600,cursor:'pointer' }}>+ 추가</button>}>
      <div style={{ padding:'12px 16px 16px' }}>
        <div style={{ background:C.surface,border:`1px solid ${C.borderLight}`,borderRadius:16,overflow:'hidden' }}>
          {Object.values(SHIFTS).map((s,i,arr)=>(
            <div key={s.id} style={{ display:'flex',alignItems:'center',padding:'13px 16px',
              borderBottom:i<arr.length-1?`1px solid ${C.borderLight}`:'none' }}>
              <span style={{ fontSize:16,color:C.textTertiary,marginRight:12,cursor:'grab' }}>☰</span>
              <div style={{ width:38,height:38,borderRadius:10,background:s.bg,
                display:'flex',alignItems:'center',justifyContent:'center',marginRight:12 }}>
                <span style={{ fontSize:12,fontWeight:800,color:s.color }}>{s.abbr}</span>
              </div>
              <div style={{ flex:1 }}>
                <div style={{ fontSize:14,fontWeight:600,color:C.text }}>{s.name}</div>
                {s.time&&<div style={{ fontSize:11,color:C.textSub }}>{s.time}</div>}
              </div>
              <span style={{ color:C.textTertiary,fontSize:18 }}>›</span>
            </div>
          ))}
        </div>
      </div>
      {showForm&&<ShiftTypeFormSheet onClose={()=>setShowForm(false)}/>}
    </SubScreen>
  );
}

function ShiftTypeFormSheet({ onClose }) {
  return (
    <div style={{ position:'absolute',inset:0,zIndex:50 }} onClick={onClose}>
      <div style={{ position:'absolute',inset:0,background:'rgba(0,0,0,0.28)' }}/>
      <div onClick={e=>e.stopPropagation()} style={{
        position:'absolute',bottom:0,left:0,right:0,
        background:C.surface,borderRadius:'24px 24px 0 0',padding:'10px 20px 36px' }}>
        <div style={{ width:36,height:4,background:C.border,borderRadius:2,margin:'0 auto 16px' }}/>
        <h3 style={{ fontSize:16,fontWeight:700,color:C.text,marginBottom:16 }}>근무타입 추가</h3>
        {[['이름','오전 근무'],['약어','오전'],['카테고리','WORK'],['시작 시간','09:00'],['종료 시간','18:00']].map(([l,p])=>(
          <div key={l} style={{ marginBottom:12 }}>
            <div style={{ fontSize:12,fontWeight:600,color:C.textSub,marginBottom:5 }}>{l}</div>
            <input placeholder={p} style={{ width:'100%',padding:'10px 12px',borderRadius:10,
              border:`1.5px solid ${C.border}`,fontSize:13,color:C.text,background:C.surfaceVariant,outline:'none' }}/>
          </div>
        ))}
        <button style={{ width:'100%',padding:13,borderRadius:12,border:'none',
          background:C.primary,color:'#fff',fontSize:14,fontWeight:700,cursor:'pointer' }}>저장하기</button>
      </div>
    </div>
  );
}

function VacationScreen({ onBack }) {
  const [max,setMax]=useState(3);
  const overrides=[{date:'3/15',max:5},{date:'3/22',max:2},{date:'3/25',max:0}];
  return (
    <SubScreen title="휴가 MAX 설정" onBack={onBack}>
      <div style={{ padding:'0 16px 16px' }}>
        <div style={{ background:C.surface,border:`1px solid ${C.borderLight}`,borderRadius:16,padding:'20px 16px',marginBottom:16 }}>
          <div style={{ fontSize:13,fontWeight:600,color:C.textSub,marginBottom:16 }}>기본 일일 최대 인원</div>
          <div style={{ display:'flex',alignItems:'center',justifyContent:'center',gap:20 }}>
            <button onClick={()=>setMax(m=>Math.max(0,m-1))} style={{ width:44,height:44,borderRadius:'50%',
              border:`1.5px solid ${C.border}`,background:C.surfaceVariant,fontSize:20,cursor:'pointer' }}>−</button>
            <div style={{ textAlign:'center' }}>
              <div style={{ fontSize:32,fontWeight:800,color:C.primary }}>{max}</div>
              <div style={{ fontSize:11,color:C.textSub }}>명</div>
            </div>
            <button onClick={()=>setMax(m=>m+1)} style={{ width:44,height:44,borderRadius:'50%',
              border:`1.5px solid ${C.primary}`,background:C.primaryBg,fontSize:20,cursor:'pointer',color:C.primary }}>+</button>
          </div>
        </div>
        <div style={{ display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:10 }}>
          <span style={{ fontSize:13,fontWeight:600,color:C.text }}>날짜별 예외 설정</span>
          <button style={{ fontSize:12,fontWeight:600,color:C.primary,background:C.primaryBg,
            border:'none',borderRadius:8,padding:'6px 12px',cursor:'pointer' }}>+ 예외 추가</button>
        </div>
        <div style={{ display:'flex',flexWrap:'wrap',gap:8 }}>
          {overrides.map(o=>(
            <div key={o.date} style={{ display:'flex',alignItems:'center',gap:8,
              background:C.surfaceVariant,borderRadius:10,padding:'8px 12px' }}>
              <span style={{ fontSize:13,fontWeight:600,color:C.text }}>{o.date}</span>
              <span style={{ fontSize:12,color:C.primary,fontWeight:700 }}>{o.max}명</span>
              <button style={{ background:'none',border:'none',cursor:'pointer',fontSize:14,color:C.textSub,padding:0 }}>×</button>
            </div>
          ))}
        </div>
      </div>
    </SubScreen>
  );
}

function EventsScreen({ onBack }) {
  const [q,setQ]=useState('');
  const filtered=EVENTS.filter(e=>e.title.includes(q));
  return (
    <SubScreen title="이벤트 관리" onBack={onBack}
      right={<button style={{ background:C.primary,color:'#fff',border:'none',borderRadius:8,
        padding:'6px 14px',fontSize:13,fontWeight:600,cursor:'pointer' }}>+ 추가</button>}>
      <div style={{ padding:'10px 16px 6px' }}>
        <input value={q} onChange={e=>setQ(e.target.value)} placeholder="이벤트 검색..."
          style={{ width:'100%',padding:'10px 14px',borderRadius:12,border:`1.5px solid ${C.border}`,
            fontSize:13,color:C.text,background:C.surfaceVariant,outline:'none' }}/>
      </div>
      <div style={{ padding:'6px 16px 16px',display:'flex',flexDirection:'column',gap:10 }}>
        {filtered.map(e=>(
          <div key={e.id} style={{ background:C.surface,border:`1px solid ${C.borderLight}`,
            borderRadius:16,padding:'14px 16px',borderLeft:`4px solid ${e.color}` }}>
            <div style={{ display:'flex',alignItems:'center',gap:8,marginBottom:4 }}>
              <div style={{ width:10,height:10,borderRadius:'50%',background:e.color }}/>
              <span style={{ fontSize:15,fontWeight:700,color:C.text }}>{e.title}</span>
            </div>
            <div style={{ fontSize:12,color:C.textSub }}>{e.s===e.e?`3/${e.s}`:`3/${e.s}~3/${e.e}`}</div>
            {e.memo&&<div style={{ fontSize:12,color:C.textSub,marginTop:4 }}>{e.memo}</div>}
          </div>
        ))}
      </div>
    </SubScreen>
  );
}

// ═══════════════════════════════════════════════════════════
// BOTTOM NAV + APP ROOT
// ═══════════════════════════════════════════════════════════
function BottomNav({ tab, onChange, submitted }) {
  const tabs=[
    {id:'home',     icon:'🏠', label:'홈'},
    {id:'schedule', icon:'📝', label:'근무신청'},
    {id:'settings', icon:'⚙️', label:'설정'},
  ];
  return (
    <div style={{ height:64,display:'flex',borderTop:`0.5px solid ${C.borderLight}`,background:C.surface,flexShrink:0 }}>
      {tabs.map(t=>(
        <button key={t.id} onClick={()=>onChange(t.id)} style={{
          flex:1,display:'flex',flexDirection:'column',alignItems:'center',justifyContent:'center',
          background:tab===t.id?C.primaryBg:C.surface,
          border:'none',cursor:'pointer',gap:3,transition:'background 0.15s',position:'relative' }}>
          <span style={{ fontSize:22,lineHeight:1 }}>{t.icon}</span>
          <span style={{ fontSize:10,fontWeight:700,color:tab===t.id?C.primary:C.textSub }}>{t.label}</span>
          {/* 제출 직후 홈탭 반영 알림 뱃지 */}
          {t.id==='home'&&submitted&&tab!=='home'&&(
            <div style={{ position:'absolute',top:8,right:'20%',width:8,height:8,
              borderRadius:'50%',background:C.success,border:'2px solid #fff' }}/>
          )}
        </button>
      ))}
    </div>
  );
}

export default function App() {
  const [tab,setTab]                 = useState('home');
  // 제출된 나의 근무 — 전역 상태 (홈과 근무신청 화면이 공유)
  const [submittedAssign,setSubmitted] = useState(null);

  const handleSubmit = (assign, now) => {
    assign.__submittedAt = now;
    setSubmitted(assign);
    // 제출 직후 홈 탭으로 이동해서 반영 확인
    setTimeout(()=>setTab('home'), 300);
  };

  return (
    <div style={{
      maxWidth:390,margin:'0 auto',height:'100vh',
      display:'flex',flexDirection:'column',
      fontFamily:"'Noto Sans KR', -apple-system, sans-serif",
      background:C.bg,position:'relative',overflow:'hidden',
      boxShadow:'0 0 40px rgba(0,0,0,0.12)',
    }}>
      <div style={{ flex:1,overflow:'hidden',display:'flex',flexDirection:'column',position:'relative' }}>
        {tab==='home'     && <SharedCalendarScreen submittedAssign={submittedAssign}/>}
        {tab==='schedule' && <WorkerCalendarScreen onSubmit={handleSubmit} submittedAssign={submittedAssign}/>}
        {tab==='settings' && <SettingsScreen/>}
      </div>
      <BottomNav tab={tab} onChange={setTab} submitted={!!submittedAssign}/>
    </div>
  );
}
